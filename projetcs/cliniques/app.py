import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

# Configuration de la page Streamlit
st.set_page_config(page_title="Maturité Digitale des Cliniques", layout="wide")
st.title("Dashboard : Analyse de la Maturité Digitale des Cliniques")

# Chargement des données
@st.cache_data
def load_data():
    """
    Charge les données nettoyées depuis le fichier CSV.
    """
    df = pd.read_csv('donnees_cliniques_nettoyees.csv', parse_dates=['survey_start_datetime', 'survey_end_datetime', 'submission_time'])
    return df

df = load_data()

# --- Section Maturité Digitale ---
st.header("1. Cartographie de la Maturité Digitale")

# Colonnes binaires pertinentes pour la maturité digitale
digital_maturity_cols = [
    'has_informatic_management_system',
    'uses_website',
    'uses_social_media',
    'uses_digital_tools_for_appointments'
]

# Vérification de l'existence des colonnes
missing_cols = [col for col in digital_maturity_cols if col not in df.columns]
if missing_cols:
    st.error(f"Les colonnes suivantes sont manquantes dans les données et sont nécessaires pour l'analyse : {missing_cols}")
    st.stop() # Arrête l'exécution de l'application si des colonnes sont manquantes

# --- CORRECTION DES TYPES JUSTE AVANT CALCUL ---
# Cette section garantit que les colonnes sont numériques avant la somme
for col in digital_maturity_cols:
    # Convertir en chaîne pour uniformiser (gère potentiellement '1', '0', 'Oui', 'Non', etc.)
    df[col] = df[col].astype(str)
    # Remplacer 'Oui', '1', etc. par 1, 'Non', '0', 'nan', etc. par 0
    df[col] = df[col].replace({
        'Oui': 1, '1': 1,
        'Non': 0, '0': 0,
        'Partiellement (mixte entre papier et numérique)': 1, # Exemple supplémentaire
        'nan': pd.NA, '<NA>': pd.NA # Remplacer les chaînes 'nan' et '<NA>' par pd.NA
    })
    # Convertir en Int8 (permet les NA) pour garantir le type numérique binaire
    df[col] = pd.to_numeric(df[col], errors='coerce').astype('Int8')

# Calcul des pourcentages *après* correction des types
percentages = {}
for col in digital_maturity_cols:
    total_non_null = df[col].notna().sum()
    if total_non_null > 0:
        percentage = (df[col].sum() / total_non_null) * 100
    else:
        percentage = 0 # Si toutes les valeurs sont nulles
    percentages[col] = percentage

# Calcul du nombre de canaux digitaux par clinique *après* correction des types
df['num_digital_channels'] = df[digital_maturity_cols].sum(axis=1, skipna=True)
mean_channels = df['num_digital_channels'].mean()

# Catégorisation par taille (ajustez le seuil si nécessaire)
bed_threshold = 30
if 'number_of_beds' in df.columns:
    df['size_category'] = df['number_of_beds'].apply(lambda x: 'Petite (<=30 lits)' if pd.notna(x) and x <= bed_threshold else 'Grande (>30 lits)')
else:
    st.error("La colonne 'number_of_beds' est absente. Impossible de comparer par taille.")
    df['size_category'] = 'Inconnue'

# --- Affichage des indicateurs ---
st.subheader("Indicateurs Clés")
col1, col2 = st.columns(2)
with col1:
    st.metric(label="Nb. moyen de canaux digitaux", value=f"{mean_channels:.2f}")
with col2:
    # Calcul du score de maturité (logique simplifiée, reprise du script précédent)
    # S'assurer que les colonnes utilisées pour le score sont numériques
    df['maturity_score_features'] = df[digital_maturity_cols].sum(axis=1, min_count=1)
    df['maturity_score_channels'] = df['num_digital_channels'].apply(lambda x: 1 if pd.notna(x) and x > 2 else 0)
    df['maturity_score'] = df['maturity_score_features'] + df['maturity_score_channels']
    df['maturity_score'] = df['maturity_score'].fillna(0)
    avg_maturity_score = df['maturity_score'].mean()
    st.metric(label="Score moyen de maturité (0-5)", value=f"{avg_maturity_score:.2f}")


# --- Affichage des Graphiques avec Plotly Express ---
st.subheader("Graphiques")

# Graphique 1 : Pourcentage de cliniques avec chaque fonctionnalité (Bar Plot)
if percentages:
    plot_data = pd.DataFrame(list(percentages.items()), columns=['Fonctionnalité', 'Pourcentage'])
    fig1 = px.bar(plot_data, x='Fonctionnalité', y='Pourcentage',
                  title='Pourcentage de Cliniques avec Fonctionnalités Numériques',
                  color_discrete_sequence=['skyblue'],
                  text_auto='.2f') # Affiche les valeurs sur les barres
    fig1.update_xaxes(tickangle=45)
    fig1.update_layout(yaxis_title="Pourcentage (%)")
    st.plotly_chart(fig1, use_container_width=True)

# Graphique 2 : Distribution du nombre de canaux digitaux (Histogram)
# On crée une série pour l'histogramme
hist_data = df['num_digital_channels'].dropna() # On retire les NA pour l'histogramme
fig2 = px.histogram(x=hist_data, nbins=max(5, int(hist_data.max()) + 1), # Ajuste le nombre de bins
                    title='Distribution du Nombre de Canaux Digitaux Utilisés',
                    labels={'x': 'Nombre de Canaux Digitaux', 'y': 'Nombre de Cliniques'},
                    color_discrete_sequence=['lightgreen'])
fig2.update_layout(xaxis_title="Nombre de Canaux Digitaux", yaxis_title="Nombre de Cliniques")
st.plotly_chart(fig2, use_container_width=True)

# Graphique 3 : Comparaison Petites vs Grandes Cliniques (fonctionnalités) - Bar Plot Groupé
if 'size_category' in df.columns and df['size_category'].nunique() > 1:
    comparison_data_long = df.groupby('size_category')[digital_maturity_cols].apply(
        lambda x: (x.sum() / x.count()) * 100 if x.count().sum() > 0 else pd.Series([0]*len(digital_maturity_cols), index=digital_maturity_cols)
    ).reset_index().melt(id_vars='size_category', var_name='Fonctionnalité', value_name='Pourcentage')

    fig3 = px.bar(comparison_data_long, x='Fonctionnalité', y='Pourcentage', color='size_category',
                  title='Comparaison de la Maturité Numérique (Petites vs Grandes Cliniques)',
                  barmode='group',
                  labels={'Fonctionnalité': 'Fonctionnalité Numérique', 'Pourcentage': 'Pourcentage (%)'})
    fig3.update_xaxes(tickangle=45)
    st.plotly_chart(fig3, use_container_width=True)
else:
    st.info("Impossible d'afficher la comparaison par taille : pas assez de catégories différentes ou colonne absente.")

# Graphique 4 : Comparaison Petites vs Grandes Cliniques (nombre moyen de canaux) - Bar Plot
if 'size_category' in df.columns and df['size_category'].nunique() > 1:
    mean_channels_by_size_df = df.groupby('size_category')['num_digital_channels'].mean().reset_index()
    mean_channels_by_size_df = mean_channels_by_size_df.dropna() # Retirer les groupes avec NA si besoin

    fig4 = px.bar(mean_channels_by_size_df, x='size_category', y='num_digital_channels',
                  title='Nombre Moyen de Canaux Digitaux par Taille de Clinique',
                  labels={'size_category': 'Taille de la Clinique', 'num_digital_channels': 'Nombre Moyen de Canaux'},
                  color_discrete_sequence=['orange'])
    st.plotly_chart(fig4, use_container_width=True)
else:
    st.info("Impossible d'afficher la comparaison par taille (moyenne) : pas assez de catégories différentes ou colonne absente.")

# Graphique 5 : Distribution du Score de Maturité (Histogram)
score_hist_data = df['maturity_score'].dropna() # On retire les NA pour l'histogramme
fig5 = px.histogram(x=score_hist_data, nbins=max(6, int(score_hist_data.max()) + 2), # Score de 0 à 5 -> 6 bins
                    range_x=[-0.5, 5.5], # Centrer les bins sur les entiers
                    title='Distribution du Score de Maturité Digitale (0-5)',
                    labels={'x': 'Score de Maturité', 'y': 'Nombre de Cliniques'},
                    color_discrete_sequence=['lightcoral'])
fig5.update_layout(xaxis_title="Score de Maturité", yaxis_title="Nombre de Cliniques")
st.plotly_chart(fig5, use_container_width=True)

# --- Pied de page ---
st.markdown("---")
st.caption("Données : Évaluation des besoins des cliniques privées.")
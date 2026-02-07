"""
Système de Recommandation Intelligent pour Cliniques
=====================================================

Ce module implémente un moteur de recommandation basé sur le machine learning
pour suggérer les solutions digitales les plus adaptées à chaque clinique.

Auteur: Équipe Analyse Santé
Date: Février 2025
"""

import pandas as pd
import numpy as np
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from typing import List, Dict, Tuple


class ClinicRecommendationEngine:
    """
    Moteur de recommandation pour solutions digitales adaptées aux cliniques.
    """
    
    def __init__(self):
        self.scaler = StandardScaler()
        self.kmeans = None
        self.solutions_catalog = self._init_solutions_catalog()
        
    def _init_solutions_catalog(self) -> Dict:
        """
        Initialise le catalogue de solutions disponibles avec leurs caractéristiques.
        """
        return {
            'RDV en ligne': {
                'complexity': 'faible',
                'cost_monthly': 50_000,
                'setup_cost': 200_000,
                'min_beds': 5,
                'roi_months': 4,
                'impact_score': 95
            },
            'Facturation automatique': {
                'complexity': 'faible',
                'cost_monthly': 70_000,
                'setup_cost': 300_000,
                'min_beds': 5,
                'roi_months': 3,
                'impact_score': 85
            },
            'DPE (Dossiers Patients Électroniques)': {
                'complexity': 'moyenne',
                'cost_monthly': 150_000,
                'setup_cost': 800_000,
                'min_beds': 15,
                'roi_months': 9,
                'impact_score': 90
            },
            'Analyse de données IA': {
                'complexity': 'élevée',
                'cost_monthly': 100_000,
                'setup_cost': 600_000,
                'min_beds': 20,
                'roi_months': 8,
                'impact_score': 80
            },
            'Gestion intelligente des stocks': {
                'complexity': 'moyenne',
                'cost_monthly': 80_000,
                'setup_cost': 400_000,
                'min_beds': 15,
                'roi_months': 10,
                'impact_score': 70
            },
            'Système Informatique Hospitalier complet': {
                'complexity': 'élevée',
                'cost_monthly': 250_000,
                'setup_cost': 1_500_000,
                'min_beds': 30,
                'roi_months': 12,
                'impact_score': 95
            }
        }
    
    def fit(self, df: pd.DataFrame, n_clusters: int = 4) -> 'ClinicRecommendationEngine':
        """
        Entraîne le modèle de clustering sur les données des cliniques.
        
        Args:
            df: DataFrame contenant les données des cliniques
            n_clusters: Nombre de clusters à créer
            
        Returns:
            self: Instance du moteur entraîné
        """
        # Sélectionner et préparer les features
        features = ['number_of_beds', 'number_of_healthcare_staff']
        df_clean = df[features].copy()
        df_clean = df_clean.fillna(df_clean.mean())
        
        # Normaliser
        X_scaled = self.scaler.fit_transform(df_clean)
        
        # Entraîner K-Means
        self.kmeans = KMeans(n_clusters=n_clusters, random_state=42, n_init=10)
        self.kmeans.fit(X_scaled)
        
        return self
    
    def predict_cluster(self, clinic_data: Dict) -> int:
        """
        Prédit le cluster d'une clinique.
        
        Args:
            clinic_data: Dictionnaire avec les données de la clinique
            
        Returns:
            cluster_id: ID du cluster
        """
        if self.kmeans is None:
            raise ValueError("Le modèle doit être entraîné avant de faire des prédictions")
        
        # Préparer les données
        features = np.array([[
            clinic_data.get('number_of_beds', 20),
            clinic_data.get('number_of_healthcare_staff', 15)
        ]])
        
        # Normaliser et prédire
        features_scaled = self.scaler.transform(features)
        cluster = self.kmeans.predict(features_scaled)[0]
        
        return int(cluster)
    
    def calculate_match_score(self, clinic_data: Dict, solution_name: str) -> float:
        """
        Calcule le score de pertinence d'une solution pour une clinique.
        
        Args:
            clinic_data: Données de la clinique
            solution_name: Nom de la solution
            
        Returns:
            score: Score de 0 à 100
        """
        solution = self.solutions_catalog.get(solution_name)
        if not solution:
            return 0.0
        
        score = 0.0
        
        # 1. Taille de la clinique (30%)
        beds = clinic_data.get('number_of_beds', 0)
        if beds >= solution['min_beds']:
            size_score = min(100, (beds / solution['min_beds']) * 50 + 50)
            score += size_score * 0.30
        else:
            size_score = (beds / solution['min_beds']) * 50
            score += size_score * 0.30
        
        # 2. Budget disponible (25%)
        has_budget = clinic_data.get('has_dedicated_digital_budget', False)
        if has_budget:
            score += 100 * 0.25
        else:
            score += 50 * 0.25
        
        # 3. Maturité digitale (20%)
        has_system = clinic_data.get('has_informatic_management_system', False)
        if has_system:
            maturity_score = 80
        else:
            maturity_score = 40
        score += maturity_score * 0.20
        
        # 4. Urgence/Besoin exprimé (15%)
        # Simplification: assume tous ont un besoin modéré
        score += 70 * 0.15
        
        # 5. Impact de la solution (10%)
        score += solution['impact_score'] * 0.10
        
        return round(score, 1)
    
    def recommend(self, clinic_data: Dict, top_n: int = 5) -> List[Dict]:
        """
        Génère des recommandations personnalisées pour une clinique.
        
        Args:
            clinic_data: Données de la clinique
            top_n: Nombre de recommandations à retourner
            
        Returns:
            recommendations: Liste de recommandations triées par score
        """
        recommendations = []
        
        for solution_name, solution_info in self.solutions_catalog.items():
            # Calculer le score
            match_score = self.calculate_match_score(clinic_data, solution_name)
            
            # Déterminer la priorité
            if match_score >= 80:
                priority = '🔴 TRÈS HAUTE'
            elif match_score >= 65:
                priority = '🟡 HAUTE'
            elif match_score >= 50:
                priority = '🟢 MOYENNE'
            else:
                priority = '⚪ FAIBLE'
            
            # Déterminer si c'est un quick win
            is_quick_win = (solution_info['complexity'] == 'faible' and 
                          solution_info['roi_months'] <= 6)
            
            recommendations.append({
                'solution': solution_name,
                'score': match_score,
                'priority': priority,
                'quick_win': is_quick_win,
                'cost_monthly': solution_info['cost_monthly'],
                'setup_cost': solution_info['setup_cost'],
                'roi_months': solution_info['roi_months'],
                'complexity': solution_info['complexity'],
                'impact': solution_info['impact_score']
            })
        
        # Trier par score décroissant
        recommendations.sort(key=lambda x: x['score'], reverse=True)
        
        return recommendations[:top_n]
    
    def recommend_bundle(self, clinic_data: Dict, budget_max: int) -> Dict:
        """
        Recommande un bundle de solutions optimal selon le budget.
        
        Args:
            clinic_data: Données de la clinique
            budget_max: Budget maximum disponible (FCFA/mois)
            
        Returns:
            bundle: Dictionnaire avec les solutions recommandées et le coût total
        """
        # Obtenir toutes les recommandations
        all_recommendations = self.recommend(clinic_data, top_n=len(self.solutions_catalog))
        
        # Sélectionner les solutions qui rentrent dans le budget
        selected_solutions = []
        total_monthly_cost = 0
        total_setup_cost = 0
        
        # Prioriser les quick wins et les scores élevés
        for reco in all_recommendations:
            new_monthly = total_monthly_cost + reco['cost_monthly']
            
            if new_monthly <= budget_max:
                selected_solutions.append(reco)
                total_monthly_cost = new_monthly
                total_setup_cost += reco['setup_cost']
        
        return {
            'solutions': selected_solutions,
            'total_monthly_cost': total_monthly_cost,
            'total_setup_cost': total_setup_cost,
            'budget_remaining': budget_max - total_monthly_cost,
            'count': len(selected_solutions)
        }
    
    def generate_report(self, clinic_name: str, clinic_data: Dict) -> str:
        """
        Génère un rapport de recommandations formaté.
        
        Args:
            clinic_name: Nom de la clinique
            clinic_data: Données de la clinique
            
        Returns:
            report: Rapport formaté en texte
        """
        recommendations = self.recommend(clinic_data)
        
        report = f"\n{'='*70}\n"
        report += f"RAPPORT DE RECOMMANDATIONS - {clinic_name}\n"
        report += f"{'='*70}\n\n"
        
        report += f"📊 PROFIL DE LA CLINIQUE\n"
        report += f"  • Nombre de lits: {clinic_data.get('number_of_beds', 'N/A')}\n"
        report += f"  • Personnel: {clinic_data.get('number_of_healthcare_staff', 'N/A')}\n"
        report += f"  • Système informatique: {'Oui' if clinic_data.get('has_informatic_management_system') else 'Non'}\n"
        report += f"  • Budget dédié digital: {'Oui' if clinic_data.get('has_dedicated_digital_budget') else 'Non'}\n\n"
        
        report += f"🎯 TOP {len(recommendations)} RECOMMANDATIONS\n\n"
        
        for i, reco in enumerate(recommendations, 1):
            report += f"{i}. {reco['solution']} {' 🚀 QUICK WIN' if reco['quick_win'] else ''}\n"
            report += f"   Score de pertinence: {reco['score']}/100 - {reco['priority']}\n"
            report += f"   Coût mensuel: {reco['cost_monthly']:,} FCFA | Setup: {reco['setup_cost']:,} FCFA\n"
            report += f"   ROI: {reco['roi_months']} mois | Complexité: {reco['complexity']} | Impact: {reco['impact']}/100\n\n"
        
        report += f"{'='*70}\n"
        
        return report


def main():
    """
    Exemple d'utilisation du moteur de recommandation.
    """
    # Créer le moteur
    engine = ClinicRecommendationEngine()
    
    # Exemple de clinique
    clinic_example = {
        'name': 'Clinique Exemple',
        'number_of_beds': 25,
        'number_of_healthcare_staff': 18,
        'has_informatic_management_system': False,
        'has_dedicated_digital_budget': True
    }
    
    # Générer recommandations
    recommendations = engine.recommend(clinic_example)
    
    # Afficher le rapport
    report = engine.generate_report(clinic_example['name'], clinic_example)
    print(report)
    
    # Bundle selon budget
    print("\n💰 BUNDLE SELON BUDGET (200,000 FCFA/mois)\n")
    bundle = engine.recommend_bundle(clinic_example, budget_max=200_000)
    print(f"Solutions sélectionnées: {bundle['count']}")
    print(f"Coût mensuel total: {bundle['total_monthly_cost']:,} FCFA")
    print(f"Coût setup total: {bundle['total_setup_cost']:,} FCFA")
    print(f"Budget restant: {bundle['budget_remaining']:,} FCFA\n")
    
    for solution in bundle['solutions']:
        print(f"  ✓ {solution['solution']}")


if __name__ == "__main__":
    main()

# Session 13 - Quick Reference Guide

## 🎯 Essential Commands

### Connection to SQLite Database

```python
# Method 1: Using sqlite3 (built-in)
import sqlite3
conn = sqlite3.connect('sales.db')
cursor = conn.cursor()
cursor.execute("SELECT * FROM customers")
results = cursor.fetchall()
conn.close()

# Method 2: Using SQLAlchemy (recommended)
from sqlalchemy import create_engine
engine = create_engine('sqlite:///sales.db')
```

### Reading Data with Pandas

```python
import pandas as pd

# Simple query
df = pd.read_sql_query("SELECT * FROM customers", engine)

# Query with parameters (SECURE)
df = pd.read_sql_query(
    "SELECT * FROM customers WHERE country = :country",
    engine,
    params={'country': 'France'}
)

# Query with JOIN
df = pd.read_sql_query("""
    SELECT c.*, o.order_id, o.total_amount
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
""", engine)
```

### Writing Data to Database

```python
# Create a DataFrame
df = pd.DataFrame({
    'name': ['Product1', 'Product2'],
    'price': [10.99, 20.99]
})

# Save to database
df.to_sql('products', engine, if_exists='append', index=False)
# if_exists options: 'fail', 'replace', 'append'
```

## 🔐 Security - Always Use Parameters!

```python
# ❌ DANGEROUS - SQL Injection risk
country = "France"
query = f"SELECT * FROM customers WHERE country = '{country}'"
df = pd.read_sql_query(query, engine)

# ✅ SAFE - Use parameters
country = "France"
query = "SELECT * FROM customers WHERE country = :country"
df = pd.read_sql_query(query, engine, params={'country': country})
```

## 📊 Common Patterns

### Pattern 1: Get Customer Statistics
```python
query = """
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(o.order_id) as nb_orders,
        SUM(o.total_amount) as total_spent,
        AVG(o.total_amount) as avg_order
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
    ORDER BY total_spent DESC
"""
df_stats = pd.read_sql_query(query, engine)
```

### Pattern 2: Time Series Analysis
```python
# Get data
df = pd.read_sql_query("SELECT order_date, total_amount FROM orders", engine)

# Convert to datetime
df['order_date'] = pd.to_datetime(df['order_date'])

# Extract components
df['year'] = df['order_date'].dt.year
df['month'] = df['order_date'].dt.month
df['day_of_week'] = df['order_date'].dt.day_name()

# Aggregate by month
monthly = df.groupby(['year', 'month'])['total_amount'].sum()
```

### Pattern 3: Export Results
```python
# To CSV
df.to_csv('export.csv', index=False, encoding='utf-8')

# To JSON
df.to_json('export.json', orient='records', indent=2)

# To Excel (requires openpyxl)
df.to_excel('export.xlsx', index=False, sheet_name='Data')

# To HTML
df.to_html('export.html', index=False)
```

## ⚡ Performance Tips

1. **Use LIMIT when testing**: `SELECT * FROM orders LIMIT 10`
2. **Select only needed columns**: `SELECT id, name FROM ...` not `SELECT *`
3. **Use one JOIN instead of multiple queries**
4. **Close connections**: Use context managers or close explicitly
5. **Use indexes** on frequently queried columns

## 🐛 Error Handling

```python
from sqlalchemy.exc import SQLAlchemyError

def safe_query(query, engine, params=None):
    try:
        df = pd.read_sql_query(query, engine, params=params)
        return df
    except SQLAlchemyError as e:
        print(f"Database error: {e}")
        return None
    except Exception as e:
        print(f"Unexpected error: {e}")
        return None
```

## 📚 Useful Functions

```python
# Get list of tables
tables = pd.read_sql_query(
    "SELECT name FROM sqlite_master WHERE type='table'",
    engine
)

# Get table info
info = pd.read_sql_query("PRAGMA table_info(customers)", engine)

# Count rows
count = pd.read_sql_query("SELECT COUNT(*) as count FROM orders", engine)
```

## 🎓 Session 13 Checklist

- [ ] Install SQLAlchemy: `pip install sqlalchemy`
- [ ] Connect to sales.db database
- [ ] Execute SELECT queries
- [ ] Use parameterized queries (security)
- [ ] Perform JOIN operations
- [ ] Aggregate data with GROUP BY
- [ ] Create new tables with to_sql()
- [ ] Export results to CSV/JSON
- [ ] Handle errors properly
- [ ] Close connections

## 📖 Additional Resources

- [Pandas SQL Documentation](https://pandas.pydata.org/docs/reference/io.html#sql)
- [SQLAlchemy Documentation](https://docs.sqlalchemy.org/)
- [Python sqlite3 Module](https://docs.python.org/3/library/sqlite3.html)

---

**Pro Tip**: Always test queries with LIMIT first, then remove it for full data extraction!

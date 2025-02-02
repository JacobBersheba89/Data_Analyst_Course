# 🌍 COVID-19 Data Dashboard

Tento projekt obsahuje několik interaktivních **dashboardů** vytvořených pomocí **Plotly** a **Dash**.  
Dashboardy umožňují analýzu dat COVID-19 a vizualizaci metrik pro různé země a kontinenty.  

---

## 📌 Obsah projektu
### 1️⃣ **Line Charts** – Vývoj kumulativních případů a úmrtí  
- 📊 **Interaktivní grafy** zobrazující **vývoj COVID-19** v čase.  
- ✅ **Možnost zoomování a filtrování dat**.  
- 🔥 Přidané **milníky** (100M, 200M atd.) do grafu celkových případů.  

### 2️⃣ **Mapa světa s COVID-19 daty**  
- 🌍 **Mapbox vizualizace** zobrazující případy podle zemí.  
- 🎨 **Barevně rozlišené kontinenty** + **velikost markerů** odpovídá poměru případů k populaci.  
- 🕵️‍♂️ **Při najetí myší zobrazí detaily** o zemi a metrikách.  

### 3️⃣ **Dashboard s výběrem kontinentu a metriky**  
- 🗺️ **Interaktivní mapa**, kde si uživatel vybírá **kontinent a metriku (např. total cases, total deaths, total vaccinations atd.)**.  
- 🔧 **Možnost filtrování dat podle posledního dne v datasetu**.  
- 🖤 **Tmavý Mapbox styl** pro lepší kontrast vizualizací.  

### 4️⃣ **Výběr TOP X zemí podle metriky**  
- 📊 **Možnost výběru TOP 5, 10, 15, 20 zemí podle zvolené metriky**.  
- 🚫 **Vynechání Číny a Indie**, protože jejich čísla mohou ovlivnit celkovou analýzu.  

---

## 🛠️ **Technologie**
- **Python** 🐍  
- **Dash** 🚀  
- **Plotly** 📊  
- **Pandas** 🏛️  
- **Seaborn & Matplotlib** 🎨  
- **Mapbox API** 🗺️  

---

## 🚀 **Jak spustit projekt**
### **🔹 Spuštění v Jupyter Notebooku**
1️⃣ Ujisti se, že máš nainstalované knihovny:  
   ```sh
   pip install dash plotly pandas

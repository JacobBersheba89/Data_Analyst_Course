# 🌍 pracovali jsme s COVIDOVÝM DatasetEM

Tento projekt obsahoval několik analýz a také interaktivních **dashboardů** vytvořených pomocí **Plotly** a **Dash** knihoven.  
Dashboardy umožňují analýzu dat a vizualizaci metrik pro různé země a kontinenty.  

---

### 1️⃣ Vizualizace 10 nejlidnatějších zemí
- **Seaborn** – stylování a vizualizace
- **Matplotlib** – tvorba grafů
<br>
- **Kontroluje, zda dataset obsahuje sloupec `population`**.
- **Skupinuje data podle zemí a získává maximální hodnotu populace**.
- **Seřazuje země podle populace a vybírá TOP 10**.
- **Vykresluje sloupcový graf (`barplot`) pomocí Seaborn**.
- **Používá `whitegrid` styl pro lepší čitelnost grafu**.
---------------------
  

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

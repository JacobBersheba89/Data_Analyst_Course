# 🌍 pracovali jsme s COVIDOVÝM Datasetem

Tento projekt obsahoval několik analýz a také interaktivních **dashboardů** vytvořených pomocí **Plotly** a **Dash** knihoven.  
Dashboardy umožňují analýzu dat a vizualizaci metrik pro různé země a kontinenty.  Níže jsou jednotlivé části finlního projektu...

---

### 1️⃣ Vizualizace 10 nejlidnatějších zemí
- ***Seaborn*** – stylování a vizualizace 📗
- ***Matplotlib*** – tvorba grafů 📘

- **Kontroluje, zda dataset obsahuje sloupec `population`**.
- **Skupinuje data podle zemí a získává maximální hodnotu populace**.
- **Seřazuje země podle populace a vybírá TOP 10**.
- **Vykresluje sloupcový graf (`barplot`) pomocí Seaborn**.
- **Používá `whitegrid` styl pro lepší čitelnost grafu**.
  
---
  

### 2️⃣ Vizualizace vztahu mezi populací a očekávanou délkou života
- ***Plotly Express*** – interaktivní vizualizace 📊  
- ***Pandas*** – manipulace s daty 🏛️  

- **Kontroluje, zda dataset obsahuje sloupce `population` a `life_expectancy`**.  
- **Řadí data sestupně podle populace a odstraňuje duplikáty zemí (`drop_duplicates`)**.  
- **Vytváří Scatter Plot (`px.scatter`) s barvami podle jednotlivých zemí**.  
- **Zobrazuje hover efekt s názvem země (`hover_name="location"`)**.  
- **Přidává dynamický titulek grafu:**  
  - 🏷️ `"The relationship between population size and life expectancy"`  
- **Používá `size_max=20` pro lepší čitelnost bodů**.  
- **Přidává podnadpis (`subtitle`), který vysvětluje výsledky vizualizace:**  
  - 💡 "The question was whether people in countries with a larger population live longer..."  

📌 **Výsledek:**  
✅ Interaktivní graf, který ukazuje, že **větší populace často znamená nižší očekávanou délku života**.  

---

### 3️⃣ Vývoj nových případů COVID-19 ve vybraných zemích  
- ***Plotly Express*** – interaktivní vizualizace 📊  
- ***Pandas*** – manipulace s daty 🏛️  

- **Načítá dataset a filtruje pouze vybrané země (`Germany`, `Belgium`, `Czechia`)**.  
- **Používá `.isin(countries)`, aby zahrnul pouze vybrané země**.  
- **Vytváří kopii datasetu (`df.copy()`), aby předešel SettingWithCopyWarning**.  
- **Konvertuje sloupec `date` na datetime pro správné zobrazení časových údajů**.  
- **Vykresluje line chart (`px.line`) pro vývoj nových případů (`new_cases`)**.  
- **Barevně rozlišuje země (`color="location"`) pro přehlednost**.  
- **Používá vlastní barevnou paletu (`px.colors.qualitative.Set2`) pro lepší vizuální dojem**.  

📌 **Výsledek:**  
✅ Interaktivní graf ukazující **vývoj nových případů COVID-19** v Německu 🇩🇪, Belgii 🇧🇪 a Česku 🇨🇿.  

---

### 4️⃣ Mapa celkového počtu COVID-19 případů podle zemí  
- ***Plotly Express*** – interaktivní vizualizace na mapě 🌍  
- ***Pandas*** – manipulace s daty 🏛️  

- **Kontroluje, zda dataset obsahuje potřebné sloupce (`location`, `continent`, `total_cases`, `population`, `latitude`, `longitude`)**.  
- **Agreguje data (`groupby`) podle zemí a kontinentů** a získává maximální hodnoty případů a populace.  
- **Vypočítává nový sloupec `cases_per_population` (počet případů vzhledem k populaci)**.  
- **Odstraňuje `NaN` hodnoty (`dropna`), aby předešel chybám při vizualizaci**.  
- **Vykresluje Mapbox Scatter Plot (`px.scatter_mapbox`)**, kde:  
  - 🎨 **Barva odpovídá kontinentu (`color="continent"`)**.  
  - 🔵 **Velikost bodů závisí na poměru `cases_per_population`**.  
  - 🖱️ **Při najetí myší zobrazí `total_cases` a `cases_per_population` ve formátu `%`**.  
- **Používá tmavý styl mapy (`mapbox_style="carto-darkmatter"`) pro lepší čitelnost**.  
- **Nastavuje velikost grafu (`width=1300`, `height=600`) pro lepší přehlednost**.  

📌 **Výsledek:**  
✅ Interaktivní **mapa**, která ukazuje **COVID-19 data** podle jednotlivých zemí.  

---

### 5️⃣ Interaktivní mapa COVID-19 dle kontinentu a metriky  
- ***Dash*** – webová aplikace 📊  
- ***Plotly Express*** – vizualizace mapy 🌍  
- ***Pandas*** – manipulace s daty 🏛️  

- **Načítá dataset a filtruje pouze data z posledního dne (`df['date'].max()`)**.  
- **Používá Mapbox API pro vykreslení interaktivní mapy (`px.scatter_mapbox`)**.  
- **Umožňuje výběr kontinentu (`dcc.Dropdown`), aby uživatel mohl filtrovat zobrazená data**.  
- **Umožňuje výběr metriky (`total_cases`, `total_deaths`, `total_tests`, `total_vaccinations`, `people_fully_vaccinated`)**.  
- **Vykresluje mapu, kde:**  
  - 🎨 **Barva odpovídá zemi (`color="location"`)**.  
  - 🔵 **Velikost bodů odpovídá hodnotě vybrané metriky (`size=metric`)**.  
  - 🖱️ **Při najetí myší zobrazí detaily země a hodnotu metriky**.  
- **Používá tmavý styl mapy (`mapbox_style="dark"`) pro lepší vizuální dojem**.  
- **Styluje layout a dropdowny pro přehlednější uživatelské rozhraní**.  

📌 **Výsledek:**  
✅ **Interaktivní dashboard**, kde si uživatel může vybrat **kontinent a sledovanou metriku** a zobrazit ji na **mapě světa**.  

---

### 6️⃣ Analýza vakcinace COVID-19 podle počtu zemí  
- ***Dash*** – webová aplikace 📊  
- ***Plotly Express*** – interaktivní vizualizace 📈  
- ***Pandas*** – manipulace s daty 🏛️  

- **Načítá dataset a filtruje pouze data z posledního dne (`df['date'].max()`)**.  
- **Umožňuje výběr počtu zemí (`5, 10, 15, 20`) pomocí `dcc.Dropdown`**.  
- **Vynechává Čínu a Indii, pokud je vybráno více než 5 zemí**, aby analýza nebyla zkreslená.  
- **Vykresluje dva bar charty (`px.bar`) s celkovým počtem očkování a poměrem očkování k populaci**:  
  - **Graf 1:** **Nejvíce očkované země podle absolutních čísel (`total_vaccinations`)** 🏥.  
  - **Graf 2:** **Nejvíce očkované země podle podílu na populaci (`vaccination_ratio`)** 📊.  
- **Používá různé barevné palety** (`Blues` pro total a `Oranges` pro ratio) pro lepší vizuální přehlednost.  
- **Styluje layout a dropdown pro přehlednější uživatelské rozhraní**.  

📌 **Výsledek:**  
✅ **Interaktivní dashboard**, kde si uživatel může vybrat **počet zemí** a analyzovat **celkovou vakcinaci a její podíl na populaci**. 

![Vizualizace vakcinace](https://github.com/JacobBersheba89/Data_Analyst_Course/raw/main/Aaa%20___final_project____/6.PNG)




---

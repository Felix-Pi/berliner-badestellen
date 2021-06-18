# Berliner-Badestellen
> Belegarbeit des Modules 'Spezielle Anwendungen der Informatik: iOS Programmierung'

## Aufgabe
> Entwicklung einer App, die Berlins Badestellen auflistet und die Details der Badestellen anzeigt, die das LAGeSo anbietet. Der Standort jeder Badestellen soll in einer Karte angezeigt werden.

## Anforderungen
* **Screen 1**: Startscreen. Liste aller Badestellen in Berlin. Es reicht, wenn der Name der Badestellen angezeigt wird.
*  **Screen 2**: Wird angezeigt, wenn man in der Listenansicht auf den Eintrag einer Badestelle klickt. Hier werden die Detailinformationen der ausgewählten Badestelle angezeigt.
* **Screen 3**: Zeigt den Standort der ausgewählten Badestelle auf der Karte an.
* Über den "Zurück"-Button in der NavigationBar soll man auf den vorherigen Screen zurückspringen können.
* Die Struktur BathingArea repräsentiert in Swift eine Badestelle. Die Eigenschaften (Properties) ergeben sich aus der Struktur der JSON-Daten.


## Links
* [SimpleSearch_JSON](https://support.berlin.de/wiki/index.php/SimpleSearch_JSON)
* [API call](https://www.berlin.de/lageso/gesundheit/gesundheitsschutz/badegewaesser/liste-der-badestellen/index.php/index/all.gjson?q=)

* [LaGeSo Badegewaesserueberwachung](https://www.berlin.de/lageso/gesundheit/gesundheitsschutz/badegewaesser/badegewaesserueberwachung/) 

## ToDo
- [ ] StartView: Get real images / add more images
- [ ] StartView: Map padding seems to be weird
- [ ] StartView:  improve sorting stuff
- [ ] StartViewadd distance to current locatin
- [ ] DetailView: improve AdditionalInfo message
- [ ] DetailView: Format Date
- [ ] DetailView: Navigate to BathingArea
- [ ] HelpView: Fix Orange quality text
- [x] Add HelpView
- [x] StartView: Add Sorting button
- [x] MapView: toggle all markers
- [x] Add current location to Map

---

## Screenshots
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/main/screenshots/bb_01.png "StartView 1")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/main/screenshots/bb_02.png "StartView 2")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/main/screenshots/bb_03.png "StartView 3")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/main/screenshots/bb_04.png "Detailiew")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/main/screenshots/bb_05.png "MapView 3")

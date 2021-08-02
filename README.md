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
- [ ] StartView: improve sorting stuff
- [ ] StartViewadd distance to current locatin
- [ ] DetailView: Navigate to BathingArea
- [x] StartView: Get real images / add more images
- [x] StartView: Map padding seems to be off
- [x] DetailView: improve AdditionalInfo message
- [x] DetailView: Format Date
- [x] Add HelpView
- [x] HelpView: Fix Orange quality text
- [x] StartView: Add Sorting button
- [x] MapView: toggle all markers
- [x] Add current location to Map

---
## Demo
[![Youtube](https://img.youtube.com/vi/f0Fleq1jzFE/hqdefault.jpg)](https://youtu.be/f0Fleq1jzFE)

## Screenshots
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_1.jpeg "StartView 1")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_6.jpeg "DetailView 1")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_7.jpeg "DetailView 2")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_8.jpeg "MapView 1")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_9.jpeg "MapView 2")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_10.jpeg "MapView 3")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_2.jpeg "StartView 2")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_3.jpeg "StartView 3")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_4.jpeg "StartView 4")
![alt text](https://github.com/Felix-Pi/berliner-badestellen/blob/docs/docs/bb_5.jpeg "StartView 5")




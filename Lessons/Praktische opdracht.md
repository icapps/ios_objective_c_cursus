# Praktische opdracht
previous: [Lesson 7: Static, Const singletons and Blocks](bear://x-callback-url/open-note?id=A88D4654-FAE2-4BC8-A160-701B091E6809-1174-000001250A06170C)
- - - -
## Reorder CollectionView
1. Edit knop toont drag handlers
2. Met de vingers een cell verplaatsen toont deze op de nieuwe plaats
3. Op de nieuwe plaats wordt de cell met standaard animatie van insert toegevoegd
## Drag and Drop CollectionView
1. Andere application op iPad dragged een tekst
2. Droppen op de app toont de text via een insert op de table view
	* [Drag and Drop with Collection and Table View - WWDC 2017 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2017/223/)
## Peak and Pop to reorder CollectionViewCells
1. Force press cell popt de cell er uit
2. cell kan je verplaatsen naar een andere plaats, reorderen van hierboven

Voorbeeld https://todo.microsoft.com


* [iOS 9 UITableView – How to “Peek and Pop” in to table cells with 3D touch? | laurenz.io](http://laurenz.io/2015/10/ios-9-uitableview-how-to-peek-and-pop-in-to-table-cells-with-3d-touch/)

##  Custom Animation voor plus button
1. Als je op de plus drukt komt de modal voor de tekst input als een geest uit een fles
2. Als je met je vinger naar beneden duwt duw je de modal interactief naar beneden

Meer info op [Building Adaptive Apps with UIKit - WWDC 2014 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2014/216/)

### Tutorial custom transitions
De tutorial kan je online vinden. Al is hij wat oud. Ik heb de code aangepast en naar swift 4 gezet. Je kan van hier starten en vertalen naar Objective-C.

* Tutorial: http://mathewsanders.com/animated-transitions-in-swift/
* Custom menu
	* Interactive transition:
		* https://github.com/doozMen/Interactive-Transition-Swift-Tutorial
	* Non interactive but interesting transition:
		* https://github.com/doozMen/Custom-Menu-Transition-Swift-Tutorial

### Tip voor transitie
Doe het in stappen:

1. Maak transitie custom zodat je presenting en presented view alle twee in de presentation container hebt na de transitie
2. Animeer de alpha waarde (niet de transitie die we willen maar goede test)
3. Probeer alpha waarde interactief te veranderen.
4. Focus nu op veranderen alpha animatie naar genie animatie:
	1. animeer piek klein vierkant naar een groot vierkant
	2. verplaats klein vierkant naar plus positie en animeer open en verplaats terug naar center
	3. *extra*: Animeer vierkant open in een driehoek open om het genie effect te krijgen.

## EXTRA

Explore the wonders of a truly dynamic language that Objective-C is. Try to make a property with @dynamic.

More info: http://theocacao.com/document.page/516
And example code : https://gist.github.com/mdippery/651966

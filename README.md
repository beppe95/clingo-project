# CLINGO PROJECT
This project has been written for the exam of Artificial Intelligence Laboratory at the University of Turin.

It consist in 2 exercises:
- *calendar*: the generation of a timetable for the Informatic Department courses of the University of Turin.
- *cargo*: the classical cargo problem as seen in **Artificial Intelligence, a Modern Approach** by Russell and Norvig.

## Calendar

The knowledge base has been populated with many predicates, some hardcoded with the available classrooms, courses and professors. Given those, in each model the predicate `slot/8` is generated, containing all the information of the time table. Then to check if the timetable is a valid one or not, few other predicates are generated and checks are made to test if the model is a valid one or not.

The folder `calendar\ui` contains a Kotlin JVM project that starting from a text file containing the `slot/8` predicates converts them in a `.csv` file allowing to import it inside Excel:

<p align="center">
  <img src="https://raw.githubusercontent.com/lamba92/clingo-project/master/stuff/calendar.png"/>
</p>

## Author

* **Cesare Iurlaro** - [CesareIurlaro](https://github.com/CesareIurlaro)
* **Giuseppe Gabbia**  - [beppe95](https://github.com/beppe95)
* **Lamberto Basti**  - [lamba92](https://github.com/lamba92)

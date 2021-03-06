# CLINGO PROJECT
This project has been written for the exam of Artificial Intelligence Laboratory at the University of Turin.

It consists in two exercises:
- *calendar*: the generation of a timetable for the Computer Science Department courses of the University of Turin.
- *cargo*: the cargo problem seen in **Artificial Intelligence, a Modern Approach** by Russell and Norvig.

## Calendar

The knowledge base has been populated with many predicates, some hardcoded with the available classrooms, courses and professors. Given those, in each model the predicate `slot/8` is generated, containing all the information of the time table. Then to check if the timetable is a valid one or not, few other predicates are generated and checks are made to test if the model is a valid one or not.

The folder `calendar\ui` contains a Kotlin JVM project that starting from a text file containing the `slot/8` predicates converts them in a `.csv` file allowing to import it inside Excel:

<p align="center">
  <img src="https://raw.githubusercontent.com/lamba92/clingo-project/master/stuff/calendar.png"/>
</p>

## Cargo
To solve this problem we used the `incremental ASP solving` approach, widely covered in Potassco User Guide and in the "Reasoning Web - Semantic Interoperability on the Web (2017)" book.<br/>To use this approach is mandatory to include the `#include <incmode>` directive in your file.

Our code for the Cargo Planning Problem uses `#program` directives to define the `base/0` subprogram which initializes and instantiates the prior knowledge base, the `step/1 (t)` subprogram which is the transition state model for each step `t > 0` and the `check/1 (t)` subprogram which checks state constraints and state goal for each step `t >= 0`.

The atom `query (t)`, provided in the incremental mode, allows to incrementally query the knowledge base at each step; his value is TRUE only for the last step `t` and FALSE for all the other steps.

We managed both **single** and **multiple** actions for each step and also the **Frame problem** resolution.

To model the problem we have been inspired by the model written in the **Artificial Intelligence, a Modern Approach** book by Russell and Norvig:

<p align="center">
  <img src="https://raw.githubusercontent.com/lamba92/clingo-project/master/stuff/cargo.png"/>
</p>

## Authors

* **Cesare Iurlaro** - [CesareIurlaro](https://github.com/CesareIurlaro)
* **Giuseppe Gabbia**  - [beppe95](https://github.com/beppe95)
* **Lamberto Basti**  - [lamba92](https://github.com/lamba92)

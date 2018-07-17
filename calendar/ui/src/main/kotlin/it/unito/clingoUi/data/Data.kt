package it.unito.clingoUi.data

import java.io.File
import java.util.regex.Pattern

data class Slot(val day: String, val classroom: String, val startTime: String,
                val endTime: String, val courseName: String, val semester: Int,
                val professor: String, val year: String){
    override fun toString() = "$courseName | $year | $classroom"
}

class ClingoResultParser(file: File) {
    private val stream = file.inputStream().bufferedReader()

    fun parseAll(): ArrayList<Slot> {
        val pattern = Pattern.compile(
                "slot\\(([a-z]{3}),([a-z]),([0-9]{1,2}),([0-9]{2}),([a-z]{3,13}),([0-9]),([a-z]{3,10}),([0-9])\\)"
        )

        val t = ArrayList<Slot>()
        stream.forEachLine {
            val matcher = pattern.matcher(it)
            if(matcher.find()) {
                t.add(Slot(
                        matcher.group(1),
                        matcher.group(2),
                        matcher.group(3),
                        matcher.group(4),
                        matcher.group(5),
                        matcher.group(6).toInt(),
                        matcher.group(7),
                        matcher.group(8)
                ))
            }
        }

        return t
    }
}
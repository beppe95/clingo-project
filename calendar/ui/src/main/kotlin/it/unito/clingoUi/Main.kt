package it.unito.clingoUi

import it.unito.clingoUi.data.ClingoResultParser
import it.unito.clingoUi.data.Slot
import java.io.File
import java.io.PrintWriter

fun main(args: Array<String>){
    val res = ClingoResultParser::class.java.classLoader.getResource("in.txt").path
    val sem1 = ArrayList<Slot>()
    val sem2 = ArrayList<Slot>()
    val csv1 = ArrayList<String>()
    val csv2 = ArrayList<String>()
    ClingoResultParser(File(res)).parseAll().forEach {
        when(it.semester){
            1 -> sem1.add(it)
            2 -> sem2.add(it)
        }
    }
    csv1.add(toCsvLine(
            sem1.filter {it.day == "lun"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem1.filter {it.day == "mar"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem1.filter {it.day == "mer"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem1.filter {it.day == "gio"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem1.filter {it.day == "ven"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine()
    ))
    csv1.add(toCsvLine(
            sem1.filter {it.day == "lun"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem1.filter {it.day == "mar"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem1.filter {it.day == "mer"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem1.filter {it.day == "gio"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem1.filter {it.day == "ven"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine()
    ))
    csv1.add(toCsvLine(
            sem1.filter {it.day == "lun"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem1.filter {it.day == "mar"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem1.filter {it.day == "mer"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem1.filter {it.day == "gio"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem1.filter {it.day == "ven"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine()
    ))
    csv1.add(toCsvLine(
            sem1.filter {it.day == "lun"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem1.filter {it.day == "mar"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem1.filter {it.day == "mer"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem1.filter {it.day == "gio"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem1.filter {it.day == "ven"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine()
    ))

    csv2.add(toCsvLine(
            sem2.filter {it.day == "lun"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem2.filter {it.day == "mar"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem2.filter {it.day == "mer"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem2.filter {it.day == "gio"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine(),
            sem2.filter {it.day == "ven"}.filter { it.startTime == "9" && it.endTime == "11" }.toLine()
    ))
    csv2.add(toCsvLine(
            sem2.filter {it.day == "lun"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem2.filter {it.day == "mar"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem2.filter {it.day == "mer"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem2.filter {it.day == "gio"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine(),
            sem2.filter {it.day == "ven"}.filter { it.startTime == "11" && it.endTime == "13" }.toLine()
    ))
    csv2.add(toCsvLine(
            sem2.filter {it.day == "lun"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem2.filter {it.day == "mar"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem2.filter {it.day == "mer"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem2.filter {it.day == "gio"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine(),
            sem2.filter {it.day == "ven"}.filter { it.startTime == "14" && it.endTime == "16" }.toLine()
    ))
    csv2.add(toCsvLine(
            sem2.filter {it.day == "lun"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem2.filter {it.day == "mar"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem2.filter {it.day == "mer"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem2.filter {it.day == "gio"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine(),
            sem2.filter {it.day == "ven"}.filter { it.startTime == "16" && it.endTime == "18" }.toLine()
    ))
    val w = PrintWriter("sem1.csv")
    csv1.forEach { w.println(it) }
    val k = PrintWriter("sem2.csv")
    csv2.forEach { k.println(it) }
    w.flush()
    k.flush()
}

private fun toCsvLine(vararg lines: String): String {
    var l = ""
    for(i in 0 until lines.size){
        l += lines[i]
        if(i != lines.size -1) l += ","
    }
    return l
}

private fun <E> List<E>.toLine(): String {
    var s = "\""
    for(i in 0 until size){
        s += this[i]
        if(i != size-1) s += "\n"
    }
    s += "\""
    return s
}

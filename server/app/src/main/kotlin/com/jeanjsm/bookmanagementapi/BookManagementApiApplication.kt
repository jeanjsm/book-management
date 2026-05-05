package com.jeanjsm.bookmanagementapi

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication(scanBasePackages = ["com"])
class BookManagementApiApplication

fun main(args: Array<String>) {
	runApplication<BookManagementApiApplication>(*args)
}

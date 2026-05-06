package com.jeanjsm.bookmanagementapi.entities.vo

data class UpdateBookRequest(
    val title: String?,
    val author: String?,
    val number: Int?
)

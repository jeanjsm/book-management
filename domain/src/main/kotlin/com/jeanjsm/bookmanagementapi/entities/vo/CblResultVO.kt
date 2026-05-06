package com.jeanjsm.bookmanagementapi.entities.vo

import com.fasterxml.jackson.annotation.JsonProperty

data class CblResultVO(
    val id: String?,
    val isbn: String,
    val title: String,
    val synopsis: String,
    val year: String,
    val authors: List<String>
)

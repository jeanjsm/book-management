package com.jeanjsm.bookmanagementapi.entities.vo

import java.math.BigDecimal

data class ImporterDto(
    val id: String,
    val isbn: String,
    val title: String,
    val number: String = "1",
    val synopsis: String,
    val labelPrice: BigDecimal? = BigDecimal.ZERO,
    val coverUrl: String? = null
)

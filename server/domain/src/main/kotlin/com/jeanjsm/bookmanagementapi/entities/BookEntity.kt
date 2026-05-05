package com.jeanjsm.bookmanagementapi.entities

import java.math.BigDecimal
import java.time.LocalDateTime

data class BookEntity(
    val id: Long? = null,
    val code: String,
    val title: String,
    val number: Int,
    val author: String,
    val paidPrice: BigDecimal = BigDecimal.ZERO,
    val labelPrice: BigDecimal = BigDecimal.ZERO,
    val barcode: String? = null,
    val coverUrl: String? = null,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now()
)

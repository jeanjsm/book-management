package com.jsma.server.web.dto

import java.time.Instant

data class ImportResponse(
    val id: Long,
    val isbn: String,
    val number: Int?,
    val status: String,
    val booksImported: Int,
    val createdAt: Instant
)

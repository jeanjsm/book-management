package com.jsma.server.web.dto

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.Size

data class BookCreateRequest(
    @field:NotBlank
    @field:Size(max = 255)
    val title: String,

    @field:Size(max = 255)
    val author: String? = null,

    @field:Size(max = 20)
    val isbn: String? = null,

    @field:Size(max = 255)
    val publisher: String? = null,

    val year: Int? = null
)

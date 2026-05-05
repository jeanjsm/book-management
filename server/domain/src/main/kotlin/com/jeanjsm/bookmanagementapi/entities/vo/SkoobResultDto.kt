package com.jeanjsm.bookmanagementapi.entities.vo

import com.fasterxml.jackson.annotation.JsonProperty

data class SkoobResultDto(
    val success: Boolean,
    val error: String,
    val response: List<SkoobResponseDto>
)

data class SkoobResponseDto(
    @JsonProperty("id")
    val id: Int,
    @JsonProperty("livro_id")
    val bookId: Int,
    @JsonProperty("titulo")
    val title: String,
    @JsonProperty("ano")
    val year: Int,
    @JsonProperty("autor")
    val author: String,
    @JsonProperty("sinopse")
    val synopsis: String,
    @JsonProperty("isbn")
    val isbn: String,
    @JsonProperty("capa_grande")
    val coverUrl: String
)

fun SkoobResponseDto.toDto() = ImporterDto(
    id = this.bookId.toString(),
    title = this.title,
    synopsis = this.synopsis,
    isbn = this.isbn,
    coverUrl = this.coverUrl
)
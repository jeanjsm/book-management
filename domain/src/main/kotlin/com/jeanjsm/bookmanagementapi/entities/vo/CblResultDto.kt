package com.jeanjsm.bookmanagementapi.entities.vo

import com.fasterxml.jackson.annotation.JsonProperty

data class CblResultDto(
    @JsonProperty("@odata.count")
    val count: Int = 0,
    val value: List<CblRecordDto> = emptyList()
)

data class CblRecordDto(
    @JsonProperty("RecordId")
    val id: String? = "",
    @JsonProperty("RowKey")
    val isbn: String,
    @JsonProperty("Title")
    val title: String = "",
    @JsonProperty("Sinopse")
    val synopsis: String = "",
    @JsonProperty("Ano")
    val year: String = "",
    @JsonProperty("Authors")
    val authors: List<String>
)

fun CblRecordDto.toDto() = ImporterDto(
    id = this.id.orEmpty(),
    isbn = this.isbn,
    title = this.title,
    synopsis = this.synopsis,

)

fun CblResultDto.toVO() = CblResultVO(
    id = this.value[0].id,
    isbn = this.value[0].isbn,
    title = this.value[0].title,
    synopsis = this.value[0].synopsis,
    year = this.value[0].year,
    authors = this.value[0].authors
)


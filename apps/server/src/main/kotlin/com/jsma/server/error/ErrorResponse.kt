package com.jsma.server.error

import com.fasterxml.jackson.annotation.JsonInclude
import java.time.Instant

@JsonInclude(JsonInclude.Include.NON_EMPTY)
data class ErrorResponse(
    val status: Int,
    val code: String,
    val message: String,
    val timestamp: Instant = Instant.now(),
    val path: String? = null,
    val details: Map<String, Any?>? = null
)

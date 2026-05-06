package com.jsma.server.error

class BadRequestException(
    message: String,
    val details: Map<String, Any?>? = null
) : RuntimeException(message)

package com.jeanjsm.bookmanagementapi.provider.http

import com.fasterxml.jackson.databind.ObjectMapper
import com.jeanjsm.bookmanagementapi.entities.vo.CblResultDto
import com.jeanjsm.bookmanagementapi.entities.vo.ImporterDto
import com.jeanjsm.bookmanagementapi.entities.vo.toDto
import com.jeanjsm.bookmanagementapi.provider.importer.ImporterProvider
import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.stereotype.Component

@Component
class CblProviderImpl(
    private val httpClient: HttpClient,
    private val objectMapper: ObjectMapper
) : ImporterProvider {

    private val url = "https://cblservicos.org.br"
    private val baseUrl = "https://isbn-search-br.search.windows.net/indexes/isbn-index/docs"

    companion object {
        private const val API_VERSION = "2016-09-01"
        private const val API_KEY = "100216A23C5AEE390338BBD19EA86D29"
        private const val API_ORIGIN = "https://www.cblservicos.org.br"
    }

    override fun getSource(): String {
        return "CBL"
    }

    override fun searchByIsbn(isbn: String): List<ImporterDto> {
        val requestBody = CblSearchDto(
            search = isbn
        )
        val uri = "$baseUrl/search?api-version=$API_VERSION"
        val request = HttpRequest.newBuilder()
            .uri(URI(uri))
            .POST(HttpRequest.BodyPublishers.ofString(objectMapper.writeValueAsString(requestBody)))
            .header("Api-Key", API_KEY)
            .header(HttpHeaders.REFERER, "$API_ORIGIN/")
            .header(HttpHeaders.ORIGIN, API_ORIGIN)
            .header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
            .build()
        val response = httpClient.send(request, HttpResponse.BodyHandlers.ofString())
        val result = objectMapper.readValue(response.body(), CblResultDto::class.java)
        return result.value.map { it.toDto() }
    }

}

data class CblSearchDto(
    val count: Boolean = true,
    val search: String,
    val searchFields: String = "FormattedKey, RowKey",
    val searchMode: String = "any",
    val skip: Int = 0,
    val top: Int = 12
)


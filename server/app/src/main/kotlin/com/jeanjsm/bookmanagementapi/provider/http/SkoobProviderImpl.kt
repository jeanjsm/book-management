package com.jeanjsm.bookmanagementapi.provider.http

import com.fasterxml.jackson.databind.ObjectMapper
import com.jeanjsm.bookmanagementapi.entities.vo.ImporterDto
import com.jeanjsm.bookmanagementapi.entities.vo.SkoobResultDto
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
class SkoobProviderImpl(
    private val httpClient: HttpClient,
    private val objectMapper: ObjectMapper
): ImporterProvider {

    companion object {
        private const val API_USER_AGENT = "okhttp/3.12.12"
    }

    private val url: String = "https://skoob.com.br"

    private val baseUrl: String = "https://api.skoob.com.br/api2"
    override fun getSource(): String = "SKOOB"

    override fun searchByIsbn(isbn: String): List<ImporterDto> {
        val request = HttpRequest.newBuilder()
            .uri(URI("$baseUrl/book/search/term:$isbn"))
            .GET()
            .header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
            .header(HttpHeaders.USER_AGENT, API_USER_AGENT)
            .build()
        val response = httpClient.send(request, HttpResponse.BodyHandlers.ofString())
        val result = objectMapper.readValue(response.body(), SkoobResultDto::class.java)
        return result.response.map { it.toDto().copy(isbn = isbn) }
    }
}
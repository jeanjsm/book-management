package com.jeanjsm.bookmanagementapi.configuration

import java.net.http.HttpClient
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class HttpProviderConfig {

    @Bean
    fun httpClient(): HttpClient {
        return HttpClient.newHttpClient()
    }

}
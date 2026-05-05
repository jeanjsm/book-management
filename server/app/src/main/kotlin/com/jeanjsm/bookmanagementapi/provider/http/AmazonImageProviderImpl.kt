package com.jeanjsm.bookmanagementapi.provider.http

import com.jeanjsm.bookmanagementapi.provider.importer.AmazonImageProvider
import org.springframework.stereotype.Component

@Component
class AmazonImageProviderImpl: AmazonImageProvider {

    companion object {
        private const val AMAZON_IMAGES_URL = "https://images-na.ssl-images-amazon.com/images/P"
        private const val AMAZON_IMAGE_FULL_SIZE = "SCRM"
        private const val AMAZON_IMAGE_SIZE = "SL700"
    }

    override fun getImageUrl(isbn: String): String {
        val arguments = listOf(AMAZON_IMAGE_FULL_SIZE, AMAZON_IMAGE_SIZE)
            .filter(String::isNotEmpty)

        val argumentsUrl = if (arguments.isNotEmpty()) {
            arguments.joinToString("_", prefix = "._", postfix = "_")
        } else {
            ""
        }
        println(argumentsUrl)

        return "$AMAZON_IMAGES_URL/${isbn}.01$argumentsUrl.jpg"
    }


}
package com.jeanjsm.bookmanagementapi.provider.importer

interface AmazonImageProvider {

    fun getImageUrl(isbn: String): String

}
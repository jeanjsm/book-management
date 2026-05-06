package com.jsma.server.domain

import jakarta.persistence.*
import java.time.Instant

@Entity
@Table(name = "import_jobs")
data class ImportJob(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Column(nullable = false)
    val isbn: String,

    @Column(nullable = true)
    val number: Int? = null,

    @Column(nullable = false)
    val status: String = "PENDING",

    @Column(nullable = true, length = 4000)
    val result: String? = null,

    @Column(nullable = false)
    val createdAt: Instant = Instant.now()
)

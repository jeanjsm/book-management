package com.jsma.server.domain

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ImportJobRepository : JpaRepository<ImportJob, Long>

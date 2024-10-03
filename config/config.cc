#include "config.h"
#include "hb.hh"

#include <MultiEngine/core/memory/MemoryAllocation.h>

void* hb_malloc_impl(size_t size) {
	return MultiEngine::memory_allocate(size);
}

void* hb_calloc_impl(size_t nmemb, size_t size) {
	return MultiEngine::memory_allocate_zero(size * nmemb);
}

void* hb_realloc_impl(void *ptr, size_t size) {
	return MultiEngine::memory_reallocate(ptr, size);
}

void  hb_free_impl(void *ptr) {
	MultiEngine::memory_free(ptr);
}
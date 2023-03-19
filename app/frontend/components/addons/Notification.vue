<script setup>
defineProps({
  type: String,
  notification: String,
  id: Number
})
</script>

<template>
  <div
    class="rounded-lg shadow-xl pointer-events-auto"
    :class="[
      type == 'error' ? 'bg-red-200' : 'bg-green-50 border border-green-100'
    ]"
  >
    <div class="overflow-hidden rounded-lg shadow-sm">
      <div class="p-4">
        <div class="flex items-start">
          <div class="flex-shrink-0">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              class="w-6 h-6"
              :class="[type == 'error' ? 'text-red-400' : 'text-green-400']"
            >
              <path
                v-if="type == 'error'"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
              />
              <path
                v-else
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
          </div>
          <div class="flex-1 w-0 ml-3">
            <p class="text-sm font-medium leading-5 text-gray-900">
              <span v-if="type == 'error'">
                Failure!
              </span>
              <span v-else>
                Success :)
              </span>
            </p>
            <p class="mt-1 text-sm leading-5 text-gray-600">
              <span v-html="notification"></span>
            </p>
          </div>
          <div class="flex flex-shrink-0 ml-4">
            <button
              @click="$emit('remove', id)"
              class="inline-flex text-gray-400 focus:outline-none"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                class="w-5 h-5"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>

<script setup>
import { ref } from 'vue'
import { useNotificationsStore } from '@/store/notifications' // Notifications Store Import
import axios from 'axios'
const notifications = useNotificationsStore()

// Data Variables
const file = ref(null)
const files = ref([])
const is_private = ref([])

// Functions
const uploadFiles = () => {
  let data = new FormData()

  for (var i = 0; i < files.value.length; i++) {
    let f = files.value[i]
    data.append('file[]', f, f.name)
    data.append('private[]', is_private.value[i] || false)
  }

  axios({
    method: 'post',
    url: 'http://localhost:3000/api/v1/add_files.json',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
    .then((response) => {
      file.value = ''
      files.value = []
      is_private.value = []
      notifications.set(response.data.message, 'success')
    })
    .catch((error) => {
      notifications.set(
        error?.response?.data?.message || 'Cannot create task',
        'error'
      )
    })
}

// handle files
const handleFileUpload = () => {
  files.value.push(...file.value.files)
}

// Remove uploaded file by trash icon
const removeFile = (index) => {
  files.value.splice(index, 1)
  files.value.length == 0 && (file.value = '')
}

// Functions for drag and drop support for Image upload
const dragover = (event) => {
  event.preventDefault()
  // Add some visual fluff to show the user can drop its files
  if (!event.currentTarget.classList.contains('bg-green-300')) {
    event.currentTarget.classList.remove('bg-gray-100')
    event.currentTarget.classList.add('bg-green-300')
  }
}
const dragleave = (event) => {
  // Clean up
  event.currentTarget.classList.add('bg-gray-100')
  event.currentTarget.classList.remove('bg-green-300')
}
const drop = (event) => {
  event.preventDefault()
  file.value.files = event.dataTransfer.files
  handleFileUpload() // Trigger the onChange event manually
  // Clean up
  event.currentTarget.classList.add('bg-gray-100')
  event.currentTarget.classList.remove('bg-green-300')
}
</script>

<template>
  <div class="px-4">
    <form @submit.prevent="uploadFiles">
      <div id="images" class="mt-4">
        <div>
          <div class="flex items-center justify-center w-full">
            <label
              class="flex flex-col items-center justify-center w-full h-32 transition duration-300 border-4 border-dashed rounded-2xl hover:bg-gray-100 hover:border-purple-300 group hover:cursor-pointer"
              @dragover="dragover"
              @dragleave="dragleave"
              @drop="drop"
            >
              <svg
                class="w-10 h-10 text-purple-400 transition duration-300 group-hover:text-purple-600"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
                ></path>
              </svg>
              <p
                class="pt-1 text-sm tracking-wider text-gray-400 transition duration-300 group-hover:text-purple-600"
              >
                Select Files
              </p>
              <input
                type="file"
                id="task_image"
                ref="file"
                required
                multiple
                @change="handleFileUpload()"
                class="hidden"
              />
            </label>
          </div>
        </div>
      </div>
      <div v-if="files.length > 0" class="mt-4">
        <span class="text-gray-300">Your Selected Files</span>
        <div>
          <table class="w-full bg-white shadow-lg table-auto">
            <thead>
              <tr>
                <th class="px-8 py-4 text-left bg-blue-100 border">
                  No.
                </th>
                <th class="px-8 py-4 text-left bg-blue-100 border">
                  Name
                </th>
                <th class="px-8 py-4 text-left bg-blue-100 border">
                  Private?
                </th>
                <th class="px-8 py-4 text-left bg-blue-100 border">
                  Delete
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(file, index) in files" :key="index">
                <td class="px-8 py-4 border">{{ index + 1 }}</td>
                <td class="px-8 py-4 border">
                  {{ `${file.name.substring(0, 30)}...` }}
                </td>
                <td class="px-8 py-4 border">
                  <input
                    type="checkbox"
                    id="checkbox"
                    v-model="is_private[index]"
                  />
                </td>
                <td class="border">
                  <div class="flex items-center justify-center">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      @click="removeFile(index)"
                      class="flex w-8 h-8 text-red-600 transition duration-300 cursor-pointer stroke-current hover:text-red-500"
                      fill="none"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                      />
                    </svg>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="mt-4 text-right">
          <button
            type="submit"
            class="px-6 py-3 text-sm font-medium leading-none text-white bg-indigo-700 rounded whitespace-nowrap focus:ring-2 hover:bg-indigo-600"
          >
            Upload Files
          </button>
        </div>
      </div>
    </form>
  </div>
</template>

<style scoped>
.fade-in-enter-active {
  transition: opacity 300ms cubic-bezier(0.55, 0.085, 0.68, 0.53);
}

.fade-in-leave-active {
  transition: opacity 225ms cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.fade-in-enter,
.fade-in-leave-to {
  opacity: 0;
}
</style>

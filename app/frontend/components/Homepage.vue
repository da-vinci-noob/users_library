<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useNotificationsStore } from '@/store/notifications' // Notifications Store Import
import api from '../plugins/axios'

// Variables
const router = useRouter()
const notifications = useNotificationsStore()
const user = ref({})

// Lifecycles
onMounted(() => {
  checkUser()
})

// Methods
const checkUser = () => {
  api({
    method: 'GET',
    url: '/api/v1/check_user'
  })
    .then((res) => {
      // Process File Lists
      user.value.email = res.data.email
    })
    .catch(() => {
      notifications.set('You are not logged in', 'error')
      router.push({ path: '/login' })
    })
}

const logoutUser = () => {
  api({
    method: 'DELETE',
    url: '/users/sign_out'
  })
    .then(() => {
      notifications.set('User Logged Out', 'success')
      router.push({ path: '/login' })
    })
    .catch(() => {
      notifications.set('User Logged Out', 'success')
      router.push({ path: '/login' })
    })
}
</script>

<template>
  <div>
    <div class="w-full h-full min-h-screen px-12 pt-2 pb-8 bg-gray-600">
      <div id="head" class="flex items-center justify-between">
        <div id="logged-in-user">
          <svg
            class="w-20 h-20 text-gray-300 fill-current"
            xmlns="http://www.w3.org/2000/svg"
            xml:space="preserve"
            style="
              shape-rendering: geometricPrecision;
              text-rendering: geometricPrecision;
              image-rendering: optimizeQuality;
              fill-rule: evenodd;
              clip-rule: evenodd;
            "
            viewBox="0 0 6.827 6.827"
          >
            <g id="Layer_x0020_1">
              <path
                class="fil0"
                d="M.96 2.136h5.013v3.336H.853V2.136H.96zm4.8.213H1.067v2.91H5.76v-2.91z"
              />
              <path
                class="fil0"
                d="M1.076 2.253v-.452h4.786v.44h-.214v-.226H1.29v.238zm.446-.457v-.441h.994v.441h-.213v-.228h-.567v.228zM4.04 2.949a1.28 1.28 0 0 1 .021 1.897l-.144-.156A1.064 1.064 0 0 0 3.9 3.108l.14-.16z"
              />
              <path
                class="fil0"
                d="m3.757 3.486.02-.54.004-.106.106.004.586.022-.008.213-.48-.019-.016.434zm-.829-.378a1.08 1.08 0 0 0-.076.074 1.064 1.064 0 0 0 .057 1.508l-.144.156a1.276 1.276 0 0 1 .022-1.897l.141.16z"
              />
              <path
                class="fil0"
                d="m2.857 3.494-.016-.434-.48.019-.007-.213.585-.022.106-.004.004.106.021.54z"
              />
            </g>
            <path style="fill: none;" d="M0 0h6.827v6.827H0z" />
          </svg>
        </div>
        <div class="space-x-4">
          <span class="text-gray-200">{{ user.email }}</span>
          <button
            @click="logoutUser"
            class="px-6 py-3 text-sm font-medium leading-none text-white bg-red-700 rounded focus:ring-2 hover:bg-red-600 focus:outline-none"
          >
            Logout
          </button>
        </div>
      </div>
      <div class="mt-8">
        <div class="text-right">
          <router-link to="/add-file">
            <button
              class="px-6 py-3 text-sm font-medium leading-none text-white bg-indigo-700 rounded focus:ring-2 sm:ml-3 hover:bg-indigo-600"
            >
              <p class="">
                Add New File
              </p>
            </button>
          </router-link>
        </div>
        <div
          class="mt-2 overflow-hidden border rounded-lg dark:border-gray-700"
        >
          <table
            class="min-w-full divide-y divide-gray-200 dark:divide-gray-700"
          >
            <thead class="text-left text-gray-400 bg-gray-800 rounded-lg">
              <tr class="">
                <th class="py-3 pl-8 text-sm font-normal">Name</th>
                <th class="text-sm font-normal">Size</th>
                <th class="text-sm font-normal">Uploaded Date</th>
                <th class="text-sm font-normal">Uploaded By</th>
                <th class="text-sm font-normal">Action</th>
              </tr>
            </thead>
            <tbody class="text-gray-200 bg-gray-700 divide-y divide-gray-500">
              <tr v-for="(item, index) in 10" :key="index">
                <td class="py-2 pl-8">Filanem</td>
                <td>24 MB</td>
                <td>Date</td>
                <td>test@test.com</td>
                <td>DELETE</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
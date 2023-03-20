<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useNotificationsStore } from '@/store/notifications' // Notifications Store Import
import api from '../plugins/axios'
const notifications = useNotificationsStore()

// Data variables
const currentPassword = ref('')
const newPass = ref('')
const newPassConfirmation = ref('')
const router = useRouter()

// Lifecycles
onMounted(() => {
  checkUser()
})

// Functions
const checkUser = () => {
  api({
    method: 'GET',
    url: '/api/v1/check_user'
  })
    .then(() => {})
    .catch(() => {
      router.push({ path: '/login' })
    })
}

const changePass = () => {
  if (!validateFields()) return
  api({
    method: 'put',
    url: 'users/password',
    data: {
      user: {
        current_password: currentPassword.value,
        password: newPass.value,
        password_confirmation: newPassConfirmation.value
      }
    }
  })
    .then(() => {
      submitSuccessful()
    })
    .catch((err) => {
      submitFailed(err.response.data.message)
    })
}

const validateFields = () => {
  if (newPass.value.length > 5) {
    if (newPass.value == newPassConfirmation.value) return true
    else
      notifications.set(
        "New Password and Password Confirmation doesn't match",
        'error'
      )
  } else
    notifications.set(
      'New Password Length should be minimum 5 characters',
      'error'
    )
}

const submitSuccessful = () => {
  notifications.set('Password Changed Successfully', 'success')
  router.push({ path: '/' })
}

const submitFailed = (error) => {
  notifications.set(error || 'Something went wrong', 'error')
}
</script>

<template>
  <div
    class="flex items-center justify-center min-h-screen px-4 py-12 bg-gray-200 sm:px-6 lg:px-8"
  >
    <div class="w-full max-w-md p-4 space-y-8 glassed">
      <div>
        <h2 class="mt-6 text-3xl font-extrabold text-center text-gray-800">
          Change Password
        </h2>
      </div>
      <form class="mt-8" @submit.prevent="changePass">
        <div>
          <span class="relative flex items-center">
            <span class="absolute inset-y-0 left-0 z-20 flex items-center px-4">
              <svg
                class="w-6 h-6 text-gray-700"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M6.2 11V9c0-2.761 2.462-5 5.5-5s5.5 2.239 5.5 5v2c1.215 0 2.2.895 2.2 2v5c0 1.105-.985 2-2.2 2h-11C4.985 20 4 19.105 4 18v-5c0-1.105.985-2 2.2-2zM15 9v2H8.4V9c0-1.657 1.477-3 3.3-3C13.523 6 15 7.343 15 9z"
                />
              </svg>
            </span>
            <input
              id="current-password"
              name="current-password"
              autocomplete="current-password"
              type="password"
              v-model="currentPassword"
              required
              class="block w-full py-4 pl-12 pr-3 text-gray-900 placeholder-gray-500 transition duration-300 ease-in-out border border-gray-300 rounded-none appearance-none rounded-t-xl focus:outline-none focus:ring-2 focus:z-10 focus:rounded-xl focus:ring-brand-primary focus:ring-opacity-40 sm:text-sm"
              placeholder="Current Password"
            />
          </span>
        </div>
        <div class="-mt-px">
          <span class="relative flex items-center">
            <span class="absolute inset-y-0 left-0 z-20 flex items-center px-4">
              <svg
                class="w-6 h-6 text-gray-700"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M6.2 11V9c0-2.761 2.462-5 5.5-5s5.5 2.239 5.5 5v2c1.215 0 2.2.895 2.2 2v5c0 1.105-.985 2-2.2 2h-11C4.985 20 4 19.105 4 18v-5c0-1.105.985-2 2.2-2zM15 9v2H8.4V9c0-1.657 1.477-3 3.3-3C13.523 6 15 7.343 15 9z"
                />
              </svg>
            </span>
            <input
              id="new-pass"
              name="new-pass"
              type="password"
              autocomplete="new-pass"
              v-model="newPass"
              required
              class="block w-full py-4 pl-12 pr-3 text-gray-900 placeholder-gray-500 transition duration-300 ease-in-out border border-gray-300 rounded-none appearance-none focus:outline-none focus:ring-2 focus:z-10 focus:rounded-xl focus:ring-brand-primary focus:ring-opacity-40 sm:text-sm"
              placeholder="New Password"
            />
          </span>
        </div>
        <div class="-mt-px">
          <span class="relative flex items-center">
            <span class="absolute inset-y-0 left-0 z-20 flex items-center px-4">
              <svg
                class="w-6 h-6 text-gray-700"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M6.2 11V9c0-2.761 2.462-5 5.5-5s5.5 2.239 5.5 5v2c1.215 0 2.2.895 2.2 2v5c0 1.105-.985 2-2.2 2h-11C4.985 20 4 19.105 4 18v-5c0-1.105.985-2 2.2-2zM15 9v2H8.4V9c0-1.657 1.477-3 3.3-3C13.523 6 15 7.343 15 9z"
                />
              </svg>
            </span>
            <input
              id="new-pass-confirmation"
              name="new-pass-confirmation"
              type="password"
              autocomplete="new-pass-confirmation"
              v-model="newPassConfirmation"
              required
              class="block w-full py-4 pl-12 pr-3 text-gray-900 placeholder-gray-500 transition duration-300 ease-in-out border border-gray-300 rounded-none appearance-none rounded-b-xl focus:outline-none focus:ring-2 focus:z-10 focus:rounded-xl focus:ring-brand-primary focus:ring-opacity-40 sm:text-sm"
              placeholder="New Password Confirmation"
            />
          </span>
        </div>

        <div class="mt-16">
          <button
            type="submit"
            class="relative flex justify-center w-full px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md group hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <svg
                class="w-5 h-5 text-brand-primary group-hover:text-indigo-400"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                aria-hidden="true"
              >
                <path
                  fill-rule="evenodd"
                  d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z"
                  clip-rule="evenodd"
                />
              </svg>
            </span>
            Change Password
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

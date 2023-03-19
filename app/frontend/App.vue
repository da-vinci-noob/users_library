<script setup>
import Notification from './components/addons/Notification.vue'
import { useNotificationsStore } from '@/store/notifications' // Notifications Store Import
const notifications = useNotificationsStore()

const removeNotification = (id) => {
  notifications.all.splice(
    notifications.all.findIndex((a) => a.id === id),
    1
  )
}
</script>

<template>
  <div class="bg-gray-100">
    <div
      v-if="notifications.all.length > 0"
      class="fixed inset-0 z-50 flex items-start justify-end px-4 py-6 pointer-events-none sm:p-6"
    >
      <div class="w-full max-w-sm">
        <transition-group
          tag="div"
          enter-active-class="transition duration-300 ease-out delay-300 transform"
          enter-class="translate-x-4 opacity-0"
          enter-to-class="translate-x-0 opacity-100"
          leave-active-class="absolute w-full max-w-sm transition duration-500 ease-out"
          leave-class="opacity-100"
          leave-to-class="opacity-0"
          move-class="transition duration-500 ease-in-out"
        >
          <Notification
            @remove="removeNotification"
            class="mt-4"
            :id="notification.id"
            :type="notification.type"
            :notification="notification.value"
            v-for="notification in notifications.all"
            :key="notification.id"
          />
        </transition-group>
      </div>
    </div>
  </div>
  <router-view></router-view>
</template>

<style></style>

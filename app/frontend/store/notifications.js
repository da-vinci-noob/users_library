import { defineStore, acceptHMRUpdate } from 'pinia'

export const useNotificationsStore = defineStore({
  id: 'notification-store',
  state: () => {
    return {
      all: []
    }
  },
  actions: {
    set(message, type) {
      var id = new Date().getTime()
      this.all.push({ id: id, type: type, value: message })
      setTimeout(() => {
        this.all.splice(
          this.all.findIndex((a) => a.id === id),
          1
        )
      }, 4000)
    }
  },
  getters: {
    get: (state) => state.all
  }
})

if (import.meta.hot) {
  import.meta.hot.accept(
    acceptHMRUpdate(useNotificationsStore, import.meta.hot)
  )
}

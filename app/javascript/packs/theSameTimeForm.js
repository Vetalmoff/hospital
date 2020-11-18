const startYear = document.getElementById('appointment_start_time_1i')
const startMonth = document.getElementById('appointment_start_time_2i')
const startDay = document.getElementById('appointment_start_time_3i')
const startHour = document.getElementById('appointment_start_time_4i')
const startMinute = document.getElementById('appointment_start_time_5i')

const endYear = document.getElementById('appointment_end_time_1i')
const endMonth = document.getElementById('appointment_end_time_2i')
const endDay = document.getElementById('appointment_end_time_3i')
const endHour = document.getElementById('appointment_end_time_4i')
const endMinutes = document.getElementById('appointment_end_time_5i')

startYear.addEventListener('change', (event) => endYear.value = event.target.value)
startMonth.addEventListener('change', (event) => endMonth.value = event.target.value)
startDay.addEventListener('change', (event) => endDay.value = event.target.value)
startHour.addEventListener('change', (event) => endHour.value = event.target.value)
startMinute.addEventListener('change', (event) => endMinutes.value = event.target.value)



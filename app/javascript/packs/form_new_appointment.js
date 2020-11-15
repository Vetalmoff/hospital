const $year = document.getElementById(appointment_start_time_1i)
const $month = document.getElementById(appointment_start_time_2i)
const $day = document.getElementById(appointment_start_time_3i)
const $hour = document.getElementById(appointment_start_time_4i)
const $minute = document.getElementById(appointment_start_time_5i)

const $endYear = document.getElementById(appointment_end_time_1i)
const $endMonth = document.getElementById(appointment_end_time_2i)
const $endDay = document.getElementById(appointment_end_time_3i)
const $endHour = document.getElementById(appointment_end_time_4i)
const $endMinute = document.getElementById(appointment_end_time_5i)

console.log('qqqqq')

$year.addEventListener("change", (event) => {
    console.log(event.target)
    $endYear.selectedIndex = $year.selectedIndex
})


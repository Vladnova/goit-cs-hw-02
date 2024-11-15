#!/bin/bash

# Список вебсайтів для перевірки
websites=("https://google.com" "https://facebook.com" "https://twitter.com")

# Файл для запису результатів
log_file="website_check_log.log"

# Очистити або створити лог-файл
> "$log_file"

#Інформуємо про початок перевірки сайтів
echo "Start checking websites"

# Перевірка доступності кожного сайту
for website in "${websites[@]}"; do
    # Використовуємо curl для перевірки HTTP статусу сайту
    http_status=$(curl -o /dev/null -s -w "%{http_code}" "$website")

    # Якщо статус 200 - сайт доступний
    if [ "$http_status" -eq 200 ]; then
        echo "[$website] is UP" | tee -a "$log_file"
    else
        echo "[$website] is DOWN (HTTP Status: $http_status)" | tee -a "$log_file"
    fi
done

# Повідомлення про завершення
echo "Results have been written to $log_file."

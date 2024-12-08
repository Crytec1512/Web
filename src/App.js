import React, { useState, useEffect } from "react";
import axios from "axios";

function App() {
  // Стейт для хранения данных студентов, текущей страницы и размера страницы
  const [students, setStudents] = useState([]);
  const [page, setPage] = useState(1);
  const [size] = useState(2);  // Максимум 2 записи на страницу
  const [total, setTotal] = useState(0);  // Общее количество студентов

  useEffect(() => {
    // Функция для запроса данных с API
    const fetchData = async () => {
      try {
        const response = await axios.get(`http://localhost:8000/data?page=${page}&size=${size}`);
        setStudents(response.data);
        // Получаем общее количество студентов из ответа (если ваш API предоставляет эту информацию)
        setTotal(3);  // Например, если в базе всего 3 записи
      } catch (error) {
        console.error("Ошибка при получении данных", error);
      }
    };

    fetchData();
  }, [page, size]);  // Функция будет вызываться при изменении страницы

  const totalPages = Math.ceil(total / size);  // Рассчитываем количество страниц

  return (
    <div>
      <h1>Студенты</h1>
      <table>
        <thead>
          <tr>
            <th>Фамилия</th>
            <th>Имя</th>
            <th>Отчество</th>
            <th>Курс</th>
            <th>Группа</th>
            <th>Факультет</th>
          </tr>
        </thead>
        <tbody>
          {students.map((student, index) => (
            <tr key={index}>
              <td>{student.surname}</td>
              <td>{student.name}</td>
              <td>{student.patronymic}</td>
              <td>{student.course}</td>
              <td>{student.group_name}</td>
              <td>{student.faculty}</td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Пагинация */}
      <div>
        <button onClick={() => setPage(page - 1)} disabled={page === 1}>
          Назад
        </button>
        <span>{page} / {totalPages}</span>
        <button onClick={() => setPage(page + 1)} disabled={page === totalPages}>
          Вперёд
        </button>
      </div>
    </div>
  );
}

export default App;


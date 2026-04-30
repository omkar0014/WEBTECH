package com.college.employeetask.controller;

import com.college.employeetask.model.Employee;
import com.college.employeetask.model.Task;
import com.college.employeetask.service.EmployeeService;
import com.college.employeetask.service.TaskService;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/tasks")
public class TaskController {

    private final TaskService taskService;
    private final EmployeeService employeeService;

    public TaskController(TaskService taskService, EmployeeService employeeService) {
        this.taskService = taskService;
        this.employeeService = employeeService;
    }

    @GetMapping
    public String listTasks(Model model) {
        model.addAttribute("tasks", taskService.getAllTasks());
        return "tasks";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("task", new Task());
        model.addAttribute("employees", employeeService.getAllEmployees());
        model.addAttribute("statusOptions", List.of("Pending", "In Progress", "Completed"));
        return "task-form";
    }

    @PostMapping("/save")
    public String saveTask(@ModelAttribute Task task) {
        if (task.getEmployee() != null && task.getEmployee().getId() != null) {
            Employee employee = employeeService.getEmployeeById(task.getEmployee().getId())
                    .orElseThrow(
                            () -> new IllegalArgumentException("Invalid employee Id:" + task.getEmployee().getId()));
            task.setEmployee(employee);
        }
        taskService.saveTask(task);
        return "redirect:/tasks";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Task task = taskService.getTaskById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid task Id:" + id));
        model.addAttribute("task", task);
        model.addAttribute("employees", employeeService.getAllEmployees());
        model.addAttribute("statusOptions", List.of("Pending", "In Progress", "Completed"));
        return "task-form";
    }

    @GetMapping("/delete/{id}")
    public String deleteTask(@PathVariable Long id) {
        taskService.deleteTask(id);
        return "redirect:/tasks";
    }
}

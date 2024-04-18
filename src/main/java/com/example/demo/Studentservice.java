package com.example.demo;

import java.util.List;
import java.util.Optional;

public interface Studentservice {
	public void savestudent(Student std);
	public List<Student> getallstudent();
	public Student singleupdate(long id);
	public Student singleupdate2(long id);
	public void deletestudent(long id);
}

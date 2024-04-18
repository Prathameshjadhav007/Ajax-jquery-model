package com.example.demo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Studentdao implements Studentservice {
    
	@Autowired
	Studentrepo sr;
	 
	//save student
	@Transactional
	public void savestudent(Student std)
	{
		sr.save(std);
	}
	
	//get all student
	public List<Student> getallstudent()
	{
		return sr.findAll();
	}
	
	//get student by id
	@Transactional
	public Student singleupdate(long id)
	{
		return sr.findById(id).get();
	}
	@Transactional
	public Student singleupdate2(long id)
	{
		return sr.findById(id).get();
	}

	//delete
	@Transactional
	public void deletestudent(long id)
	{
		sr.deleteById(id);
	}
	
}

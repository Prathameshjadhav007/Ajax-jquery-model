package com.example.demo;

import java.util.Date;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping
public class Studentcontroller {
    
	@Autowired
	Studentservice service;
	@Autowired
	Employeeservice eservice;
	
	@GetMapping("/student")
	public String studentreport()
	{	
		return "studentreport";
	}
	@GetMapping("/date")
	@ResponseBody
	public String date()
	{	
		Date date=new Date();
		
		return String.valueOf(date);
	}
	@PostMapping("/insertstudent")
	@ResponseBody
	public String savestudent(@ModelAttribute("std") Student std)
	{
		System.out.println(std.getCourse());
		service.savestudent(std);

		return "save";
	}
	@GetMapping("/getallstudent")
	public @ResponseBody List<Student> getallstudent()
	{
	  List<Student> ss= service.getallstudent();	
		return ss;
	}
	
	@GetMapping("/getonestudent/{id}")
	@ResponseBody
	public Student getbyid(@PathVariable long id)
	{
	  return service.singleupdate(id);
	}
	
	@PostMapping("/updatestudent")
	@ResponseBody
	public String updatestudent(@ModelAttribute("std") Student std)
	{
		service.savestudent(std);
		return "updated";
	}
 
	@GetMapping("/deleteStudent2/{id}")
    @ResponseBody
    public String deletestudent(@PathVariable Long id)
    {
    	service.deletestudent(id);
    	return "deleted";
    }
	@GetMapping("/favourite/{id}")
    @ResponseBody
    public String favourite(@PathVariable long id )
    {
		int id2=(int)id;
	    Employee e=new Employee();
	    Student s=service.singleupdate(id);
	   try
	   {
	    int a=(int)s.getId();
	    e.setId(a);
	    e.setName(s.getName());
	    int i=Integer.parseInt(s.getAge());  
	    e.setAge(i);
	    e.setEmail(s.getName()+"@gmail.com");
	    e.setPosition(s.getCourse());
	    eservice.regi(e);
    	return "added";
	   }
	    catch(NoSuchElementException e2)
	    {
	    	return "element not present";
	    }
    }
	@GetMapping("/favourite2/{id}")
    @ResponseBody
    public String favourite2(@PathVariable long id )
    {
		int i=(int)id;
		try
		{
		if(eservice.findbyid(i).equals(null))
		{
			return "not";
		}
		else {
		 eservice.delete(i);
    	   return "deleted";
		}
		}
		catch(NoSuchElementException e)
		{
			return "element not present";
		}
		
    }
	@GetMapping("/cheaking")
    @ResponseBody
    public Boolean cheaking(@PathVariable long id )
    {
    	   return true;
    }
	
	
}

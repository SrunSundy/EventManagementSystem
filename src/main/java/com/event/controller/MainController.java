package com.event.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping(value={"/","/home"})
	public String toHome(){
		return "home";
	}
}

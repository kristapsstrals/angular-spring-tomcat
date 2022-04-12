package tech.kriss.app.controllers;

import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController()
// @RequestMapping("test")
public class TestController {
    @GetMapping(produces = "application/json")
    public String getTest()
    {
        return "{\"hello\": [\"world\",\"test\",\"test1\"]}";
    }
}

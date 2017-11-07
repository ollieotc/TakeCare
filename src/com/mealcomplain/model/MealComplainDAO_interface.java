package com.mealcomplain.model;

import java.util.List;


public interface MealComplainDAO_interface {
	public void insert(MealComplainVO mealComplainVO);
	public void update(MealComplainVO mealComplainVO);
	public MealComplainVO findByPrimaryKey(String complainNo);
	public List<MealComplainVO> getAll();

}

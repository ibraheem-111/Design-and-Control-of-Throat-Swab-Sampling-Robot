

## IKfunction.py
This file contains a function that calculates the joint angles for an endeffector position. It uses numpy for linear algebra

## inverse_kinematics.m
contains the inverse kinematics in matlab, and also allows you to plot the behaviour as the position of the end effector changes, you can use this to verify your equations

## robot_control.py
Uses a mqtt client to listen to updates in the endeffector position, calculates joint angles and moves the servos to those angles

## mqtt_client
A basic mqtt client

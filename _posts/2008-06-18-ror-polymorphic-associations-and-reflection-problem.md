---
layout: post
title: 'ROR: Polymorphic Associations and Reflection - Problem'
date: 2008-06-18 14:46:00.000000000 -07:00
categories:
- Ruby on Rails
tags:
- Polymorphic Associations
- Ruby on Rails
permalink: "/ror-polymorphic-associations-and-reflection-problem/"
---
During the work on our industry project we came across the need to have an Document class that contains the common header information for documents and we needed this to reference a specific document such as Process, Report, etc. This is a form of inheritance and in ROR there a many ways of achieiving this. The first way is using single table inheritance which is what we wanted to avoid as this data model would be penalised using this architecture.  

ROR provides another method known as polomorphic associations and this was appropriate for our project as it allowed us to have separate tables for each Document subtype, and that we could an overall table that would represent every document in the system.  

ROR also provided a level of automation that makes it easy to traverse through objects for this data model.  

However, there still remains some pitfalls in this approach. When we want the user to create a new document, we want the ability to list the possible documents that they can create (e.g. Process, Report, etc), unfortunately there is no obvious support for listing the polymorphic association types. We could read the Document table and extract all the class names, however this only applies to class types already in the system.  

As mentioned I cannot find any obvious solutions to this problem. Some workarounds include using modules that are included in subtypes for storing class names, using the has_many_polomorphic_associations plugin, and/or putting in phantom data into the database for listing class names.  

If anyone has possible solutions, please leave a comment or send me an email.

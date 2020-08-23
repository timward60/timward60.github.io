---
layout: post
title: Auto-Saving AJAX Forms in Ruby on Rails
date: 2008-08-03 14:41:00.000000000 -07:00
categories:
- Ruby on Rails
tags:
- AJAX
- Auto-Save
- Forms
- Ruby on Rails
permalink: "/auto-saving-ajax-forms-in-ruby-on-rails/"
---
Due to the nature of Marshall (Intranet Documentation System), when users are editing documents they are often required to type quite a bit of information in to the document forms. If for any reason if they lost there current document window and lost any changes to the form they would be quiet upset.  

To combat the issue of loosing data I proceeded to research methods and approaches to implementing auto-saving. Unfortunately I couldn't find any examples of auto-saving forms for ruby on rails. As such I implemented my own implementation as follows. 

It should be noted there are potentially many different ways of implementing auto-save forms. In this example we assume that the form is part of a partial that is returned to the client through an AJAX call. That is, the form is setup as a [remote form](http://api.rubyonrails.org/classes/ActionView/Helpers/PrototypeHelper.html#M001632).  

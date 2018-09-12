import Vue from "vue";
import Router from "vue-router";
import Signin from "@/components/Signin";
import Signup from "@/components/Signup";
import Stories from "@/components/Stories";
import StoryArcs from "@/components/StoryArcs";
import StoryForm from "@/components/StoryForm";
import ForgotPassword from "@/components/ForgotPassword";
import ResetPassword from "@/components/ResetPassword";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      name: "Stories",
      component: Stories
    },
    {
      path: "/signin",
      name: "Signin",
      component: Signin
    },
    {
      path: "/signup",
      name: "Signup",
      component: Signup
    },
    {
      path: "/stories/:id",
      name: "StoryArcs",
      component: StoryArcs
    },
    {
      path: "/new-story",
      name: "StoryForm",
      component: StoryForm
    },
    {
      path: "/forgot_password",
      name: "ForgotPassword",
      component: ForgotPassword
    },
    {
      path: "/password_resets/:token",
      name: "ResetPassword",
      component: ResetPassword
    }
  ]
});

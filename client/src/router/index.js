import Vue from "vue";
import Router from "vue-router";
import Signin from "@/components/Signin";
import Signup from "@/components/Signup";
import Stories from "@/components/Stories";
import StoryArcs from "@/components/StoryArcs";
import StoryForm from "@/components/StoryForm";
import UsersList from "@/components/admin/users/List";
import EditUsers from "@/components/admin/users/EditUsers";
import UserStoriesList from "@/components/admin/users/stories/List";
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
      path: "/stories/new",
      name: "StoryForm",
      component: StoryForm
    },
    {
      path: "/admin/users",
      name: "UsersList",
      component: UsersList
    },
    {
      path: "/admin/users/:id/stories",
      name: "UserStoriesList",
      component: UserStoriesList
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
    },
    {
      path: "/admin/users/:id",
      name: "EditUsers",
      component: EditUsers
    }
  ]
});

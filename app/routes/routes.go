package routes

func RegisterRoutes(router *gin.Engine) {
	//	userController := controllers.NewUserController()

	//api := router.Group("/api/v1")
	api := router.gin
	{
		// User routes
		api.GET("/users", userController.GetUsers)
		api.POST("/users", userController.CreateUser)
	}
}

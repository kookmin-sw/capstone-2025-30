package menustore

import (
	"context"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
)

func CreateMMenu(mMenu *dbstructure.MMenu) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		_, err := mongodb.MenuColl.InsertOne(sc, mMenu)
		return nil, err
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func GetCategoryList(storeID primitive.ObjectID) ([]string, error) {
	filter := bson.M{"store_id": storeID}
	ctx := context.Background()

	results, err := mongodb.MenuColl.Distinct(ctx, "category", filter)
	if err != nil {
		return nil, err
	}

	dbCategorySet := make(map[string]bool)
	for _, cat := range results {
		if c, ok := cat.(string); ok {
			dbCategorySet[c] = true
		}
	}

	priorityOrder := []string{"커피", "차", "음료", "케이크", "빵", "샐러드"}

	var sortedCategories []string
	for _, p := range priorityOrder {
		if dbCategorySet[p] {
			sortedCategories = append(sortedCategories, p)
		}
	}

	return sortedCategories, nil
}

func GetMMenuList(storeID primitive.ObjectID, category string) ([]dbstructure.MMenu, error) {
	filter := bson.M{
		"store_id": storeID,
		"category": category,
	}

	cursor, err := mongodb.MenuColl.Find(context.Background(), filter)
	if err != nil {
		return nil, err
	}
	defer func() {
		if err := cursor.Close(context.Background()); err != nil {
			logrus.Errorf("[mongoDB GetMMenuList] cursor close failed: %v", err)
		}
	}()

	var menus []dbstructure.MMenu
	for cursor.Next(context.Background()) {
		var menu dbstructure.MMenu
		if err := cursor.Decode(&menu); err != nil {
			return nil, err
		}
		menus = append(menus, menu)
	}

	return menus, nil
}

func GetMMenuDetail(storeID primitive.ObjectID, category, menu string) (*dbstructure.MMenu, error) {
	filter := bson.M{
		"store_id": storeID,
		"category": category,
		"name":     menu,
	}

	var result dbstructure.MMenu
	err := mongodb.MenuColl.FindOne(context.Background(), filter).Decode(&result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

func FindMenuImage(storeID primitive.ObjectID, name string) (string, error) {
	filter := bson.M{
		"store_id": storeID,
		"name":     name,
	}

	var result struct {
		Image string `bson:"image"`
	}

	err := mongodb.MenuColl.FindOne(context.Background(), filter).Decode(&result)
	if err != nil {
		return "", err
	}

	return result.Image, nil
}

func IsMenuExists(storeID primitive.ObjectID, menuName string) (bool, error) {
	filter := bson.M{
		"store_id": storeID,
		"name":     menuName,
	}

	count, err := mongodb.MenuColl.CountDocuments(context.Background(), filter)
	if err != nil {
		logrus.Errorf("[mongoDB IsMenuExists] Failed to check menu existence: %v", err)
		return false, err
	}

	return count > 0, nil
}

func IsCategoryExists(storeID primitive.ObjectID, categoryName string) (bool, error) {
	filter := bson.M{
		"store_id": storeID,
		"category": categoryName,
	}

	count, err := mongodb.MenuColl.CountDocuments(context.Background(), filter)
	if err != nil {
		logrus.Errorf("[mongoDB IsCategoryExists] Failed to check menu existence: %v", err)
		return false, err
	}

	return count > 0, nil
}

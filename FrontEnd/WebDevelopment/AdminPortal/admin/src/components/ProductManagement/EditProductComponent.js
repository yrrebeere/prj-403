// import React, { useState, useEffect } from 'react';
// import ContentManagementService from '../../services/ContentManagementService';
// import styles from '../../styles/ComponentStyles.css';
// import { useParams, useNavigate } from 'react-router-dom';
//
// const EditProductComponent = () => {
//     const { product_id } = useParams();
//     const [productName, setProductName] = useState('');
//     const [image, setImage] = useState('');
//     const navigate = useNavigate();
//
//     useEffect(() => {
//         fetchData();
//     }, []);
//
//     const fetchData = async () => {
//         try {
//             const response = await ContentManagementService.getProductById(product_id);
//             const { product_name, image } = response.data;
//             setProductName(product_name);
//             setImage(image);
//         } catch (error) {
//             console.error('Error fetching product details:', error);
//         }
//     };
//
//     const handleSubmit = async (e) => {
//         e.preventDefault();
//         try {
//             await ContentManagementService.updateProduct(product_id, {
//                 product_name: productName,
//                 image: image
//             });
//             console.log('Product updated successfully');
//             navigate('/content-management');
//         } catch (error) {
//             console.error('Error updating product:', error);
//         }
//     };
//
//     return (
//         <div className={styles.body}>
//             <h1>Edit Product</h1>
//             <form onSubmit={handleSubmit}>
//                 <table className="table table-striped">
//                     <tbody>
//                     <tr>
//                         <td>Product Name</td>
//                         <td><input type="text" value={productName} onChange={(e) => setProductName(e.target.value)} /></td>
//                     </tr>
//                     </tbody>
//                 </table>
//                 <br />
//                 <div align="left" style={{ margin: '20px' }}>
//                     <button className="btn btn-primary" type="submit">Save</button>
//                 </div>
//             </form>
//         </div>
//     );
// };
//
// export default EditProductComponent;